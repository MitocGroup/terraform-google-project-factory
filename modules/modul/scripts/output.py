import os
import json
import subprocess

def main():
    # component = '{"project_default":"s3://data-lake-terrahub-us-east-1/AWSLogs/tfvars/terraform-google-project-factory/project_dafault/default.tfvars"}'
    # components = eval(component)
    components = eval(os.environ['components'])
    includ = []
    for k in components.keys():
        includ.append(k)
    includ = ','.join(includ)

    args_output = ['terrahub', 'output', '-o', 'json', '-i', includ, '-y']
    # process = subprocess.Popen(args_output, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd='/mnt/c/Terrahub/terraform-google-project-factory')
    process = subprocess.Popen(args_output, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=os.environ['root'])
    (result, error) = process.communicate()

    rc = process.wait()

    if rc != 0:
        print("Error: failed to execute command:")
        print(error)
    
    with open('output.json', 'wb') as json_file:
        json_file.write(json.dumps(json.loads(result)).encode("utf-8"))
    return 'Succes'

if __name__ == '__main__':
    RESP = main()
    print(RESP)
