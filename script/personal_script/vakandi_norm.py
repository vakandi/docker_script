import subprocess
import sys
file_ = open('FILE_fix.txt', 'w+') 
subprocess.run('c_formatter_42 < FILE', shell=True, stdout=file_) 
file_.close() 
