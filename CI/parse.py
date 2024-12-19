import subprocess
import pandas as pd
import os
from pathlib import Path
from tqdm import tqdm

exclude_list = ['.git','CI','.github','.idea']

model_paths = []

#TODO only process changed files!

for root, dirs, files in os.walk("."):
    rootpath = Path(root)
    if rootpath.parts:
        rootname = rootpath.parts[0]
    else:
        continue

    if not rootpath.is_dir():
        continue
    
    if rootname not in exclude_list:
        contains_models = False
        
        for file in files:
            if Path(file).suffix == '.sysml':
                contains_models = True
                model_paths.append({'directory':root,'file':file})



for i,model_path in tqdm(enumerate(model_paths),total=len(model_paths),desc="monticore parser"):
    path = os.path.join(model_path['directory'],model_path['file'])
    out_monticore =  subprocess.run(['java',
                                    '-jar',
                                    'CI/language-7.6.2-SNAPSHOT-cli.jar',
                                    '-i',
                                    path,
                                    '-nc'],
                                    capture_output=True)
    if out_monticore.returncode == 0:
       model_paths[i]['parsable'] = True
    else:
       model_paths[i]['parsable'] = False
       model_paths[i]['stdout'] = out_monticore.stdout.decode('utf-8')
       model_paths[i]['stderr'] = out_monticore.stderr.decode('utf-8')
            
           
        
print(model_paths)
            

            


