import os
import sys
import tempfile
import unittest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))
import run

AG_TOML = """\
[root]
values = ["repo", "help"]

[subcommands.repo]
values = ["create"]
"""

CMD_TOML = """\
[root]
command = "echo a; echo b"
"""

EMPTY_NODE_TOML = """\
[root]
"""


class TestNavigate(unittest.TestCase):
    def test_depth1_returns_root(self):
        config = {'root': {'values': ['repo']}, 'subcommands': {'repo': {'values': ['create']}}}
        self.assertEqual(run.navigate(config, ['ag'], 1), {'values': ['repo']})

    def test_depth2_returns_subcommand_node(self):
        config = {'root': {'values': ['repo']}, 'subcommands': {'repo': {'values': ['create']}}}
        self.assertEqual(run.navigate(config, ['ag', 'repo'], 2), {'values': ['create']})

    def test_depth3_returns_nested_subcommand(self):
        config = {
            'root': {'values': ['a']},
            'subcommands': {'a': {'subcommands': {'b': {'values': ['c']}}}},
        }
        self.assertEqual(run.navigate(config, ['cmd', 'a', 'b'], 3), {'values': ['c']})

    def test_unknown_subcommand_returns_none(self):
        config = {'root': {'values': ['repo']}, 'subcommands': {}}
        self.assertIsNone(run.navigate(config, ['ag', 'unknown'], 2))

    def test_missing_root_returns_none(self):
        self.assertIsNone(run.navigate({}, ['ag'], 1))


class TestFileCandidates(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()

    def tearDown(self):
        self.tmp.cleanup()

    def _touch(self, name):
        open(os.path.join(self.tmp.name, name), 'w').close()

    def test_prefix_filter(self):
        self._touch('foo.txt')
        self._touch('bar.py')
        self.assertEqual(run.file_candidates(self.tmp.name, 'f'), ['foo.txt'])

    def test_empty_prefix_returns_all(self):
        self._touch('a')
        self._touch('b')
        self.assertEqual(set(run.file_candidates(self.tmp.name, '')), {'a', 'b'})

    def test_nonexistent_cwd_returns_empty(self):
        self.assertEqual(run.file_candidates('/nonexistent/path/xyz', ''), [])


class TestCompletions(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        config_dir = os.path.join(self.tmp.name, 'config')
        os.makedirs(config_dir)
        for name, content in [('ag.toml', AG_TOML), ('cmd.toml', CMD_TOML), ('empty.toml', EMPTY_NODE_TOML)]:
            with open(os.path.join(config_dir, name), 'w') as f:
                f.write(content)
        self._orig_config_dir = run.CONFIG_DIR
        run.CONFIG_DIR = config_dir

    def tearDown(self):
        run.CONFIG_DIR = self._orig_config_dir
        self.tmp.cleanup()

    def test_values_node(self):
        self.assertEqual(run.completions('/tmp', 'ag '), 'repo\nhelp')

    def test_subcommand_values(self):
        self.assertEqual(run.completions('/tmp', 'ag repo '), 'create')

    def test_service_does_not_filter_by_partial_word(self):
        # compgen on the bash side does filtering; service returns all candidates at depth
        self.assertEqual(run.completions('/tmp', 'ag h'), 'repo\nhelp')

    def test_command_node_executes_and_returns_stdout(self):
        self.assertEqual(run.completions('/tmp', 'cmd '), 'a\nb')

    def test_no_config_falls_back_to_files(self):
        with tempfile.TemporaryDirectory() as d:
            open(os.path.join(d, 'myfile'), 'w').close()
            self.assertIn('myfile', run.completions(d, 'unknowncmd ').split('\n'))

    def test_unknown_subcommand_falls_back_to_files(self):
        with tempfile.TemporaryDirectory() as d:
            open(os.path.join(d, 'myfile'), 'w').close()
            self.assertIn('myfile', run.completions(d, 'ag nope ').split('\n'))

    def test_empty_node_falls_back_to_files(self):
        with tempfile.TemporaryDirectory() as d:
            open(os.path.join(d, 'myfile'), 'w').close()
            self.assertIn('myfile', run.completions(d, 'empty ').split('\n'))

    def test_empty_input_returns_empty(self):
        self.assertEqual(run.completions('/tmp', ''), '')


if __name__ == '__main__':
    unittest.main()
