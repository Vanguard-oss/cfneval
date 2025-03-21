from setuptools import find_packages, setup
import re

# read the contents of your README file
from pathlib import Path
this_directory = Path(__file__).parent
long_description = (this_directory / "README.md").read_text()
github_docs_base_url = "https://github.com/vanguard-oss/cfneval/blob/master/"
# Have Pypi use FQDN to Github, but everywhere else use relative links
long_description = re.compile(r"\(([a-zA-Z0-9_\-/]*.md)\)").sub(f"({github_docs_base_url}\\1)", long_description)

setup(
    author="Vanguard",
    author_email="opensource@vanguard.com",
    classifiers=[
        'Development Status :: 5 - Production/Stable',
        'Intended Audience :: Developers',
        'Natural Language :: English',
        'License :: OSI Approved :: Apache Software License',
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
    ],
    description="Evaluate and unit test CloudFormation templates",
    long_description=long_description,
    long_description_content_type='text/markdown',
    license="Apache License 2.0",
    install_requires=[
        "behave>=1.0.25",
        "jsonpath_ng<2.0.0",
        "PyYAML>=5.4.1",
        "click",
        'cfn-flip',
        'python-benedict'
    ],
    name="cfneval",
    packages=find_packages(),
    entry_points={
        "console_scripts": [
            "cfneval = cfneval.cli:cli",
            "behave-cfn = cfneval.behave_cfn:main",
        ]
    },
    url=("https://github.com/vanguard-oss/cfneval"),
    version="1.1.0",
)
