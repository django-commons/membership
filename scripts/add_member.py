import re
import sys

TERRAFORM_ORG_FILE = "./terraform/production/org.tfvars"


def add_member(content, new_member_name, team_name):
    # Regular expression to find the members list
    members_pattern = re.compile(rf"({team_name}\s*=\s*\[)([^\]]*)(\])", re.DOTALL)
    match = members_pattern.search(content)
    if match:
        # Extract the members part
        members_list = match.group(2).rstrip(",\n").replace('"', "").replace("\n  ", "").split(",")
        if new_member_name in members_list:
            print(f"Member {new_member_name} already exists in {team_name}")
            exit(1)
        # Add the new value and sort alphabetically
        members_list.append(new_member_name)
        members_list = sorted(members_list, key=str.lower)

        # Create the formatted members list as a string
        formatted_members = '\n  '.join([f'"{m}",' for m in members_list])

        # Rebuild the file content with the new members list
        new_content = content[:match.start(2)] + "\n  " + formatted_members + "\n" + content[match.end(2):]
        return new_content
    return content


def run(new_member_name, team_name):
    with open(TERRAFORM_ORG_FILE, "r") as f:
        file_content = f.read()
    updated_content = add_member(file_content, new_member_name, team_name)
    with open(TERRAFORM_ORG_FILE, "w") as f:
        f.write(updated_content)


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: python add_member.py <new_member> <team>")
        sys.exit(1)
    run(sys.argv[1], sys.argv[2])
