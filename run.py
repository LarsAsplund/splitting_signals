from vunit import VUnit
from os.path import join, dirname

prj = VUnit.from_argv()

tb_split_lib = prj.add_library('tb_split_lib')
tb_split_lib.add_source_files(join(dirname(__file__), 'test', '*.vhd'))

prj.main()
