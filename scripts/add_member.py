import re


def add_member(content, new_value):
    # Regular expression to find the members list
    members_pattern = re.compile(r"(members\s*=\s*\[)([^\]]*)(\])", re.DOTALL)
    match = members_pattern.search(content)
    if match:
        # Extract the members part
        members_list = match.group(2).rstrip(",\n").replace('"', "").replace("\n  ", "").split(",")

        # Add the new value and sort alphabetically
        members_list.append(new_value)
        members_list = sorted(members_list, key=str.lower)

        # Create the formatted members list as a string
        formatted_members = '\n  '.join([f'"{m}",' for m in members_list])

        # Rebuild the file content with the new members list
        new_content = content[:match.start(2)] + "\n  " + formatted_members + "\n" + content[match.end(2):]
        return new_content
    return content

def run(new_value):
    with open("terraform/production/org.tfvars", "r") as f:
        file_content = f.read()
    updated_content = add_member(file_content, new_value)
    with open("terraform/production/org.tfvars", "w") as f:
        f.write(updated_content)

