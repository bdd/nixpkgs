{ lib
, buildPythonPackage
, pythonOlder
, fetchPypi
, appdirs
, black
, importlib-metadata
, isPy3k
, jedi
, prompt-toolkit
, pygments
}:

buildPythonPackage rec {
  pname = "ptpython";
  version = "3.0.21";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-pXuZUurEoSVApN+0zNSiQ0A+zrJ7DRMkW15BRMhzHTI=";
  };

  propagatedBuildInputs = [
    appdirs
    black # yes, this is in install_requires
    jedi
    prompt-toolkit
    pygments
  ] ++ lib.optionals (pythonOlder "3.8") [
    importlib-metadata
  ];

  # no tests to run
  doCheck = false;

  pythonImportsCheck = [
    "ptpython"
  ];

  meta = with lib; {
    description = "An advanced Python REPL";
    homepage = "https://github.com/prompt-toolkit/ptpython";
    changelog = "https://github.com/prompt-toolkit/ptpython/blob/${version}/CHANGELOG";
    license = licenses.bsd3;
    maintainers = with maintainers; [ mlieberman85 ];
  };
}
