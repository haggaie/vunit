-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.
--
-- Copyright (c) 2014-2018, Lars Asplund lars.anders.asplund@gmail.com
library vunit_lib;
context vunit_lib.vunit_context;

library vunit_lib;
use vunit_lib.json.T_JSON;
use vunit_lib.json.jsonLoad;
use vunit_lib.json.jsonGetString;

entity tb_json_gens is
  generic (
    runner_cfg  : string;
    tb_path     : string;
    tb_cfg      : string;
    tb_cfg_file : string := "data/data.json"
  );
end entity;

architecture tb of tb_json_gens is
  constant JSONContent     : T_JSON := jsonLoad(tb_cfg);
  constant JSONFileContent : T_JSON := jsonLoad(tb_path & tb_cfg_file);
begin
  main: process
  begin
    test_runner_setup(runner, runner_cfg);
    while test_suite loop
      if run("test") then
        info("JSONContent: " & lf & JSONContent.Content);
        info("Image: " & jsonGetString(JSONContent, "Image/0") & ',' & jsonGetString(JSONContent, "Image/1"));
        info("Platform/ML505/FPGA: " & jsonGetString(JSONContent, "Platform/ML505/FPGA"));
        info("Platform/KC705/IIC/0/Devices/0/Name: " & jsonGetString(JSONContent, "Platform/KC705/IIC/0/Devices/0/Name"));

        info("tb_path & tb_cfg_file: " & tb_path & tb_cfg_file);
        info("JSONFileContent: " & lf & JSONFileContent.Content);
        info("Image: " & jsonGetString(JSONFileContent, "Image/0") & ',' & jsonGetString(JSONFileContent, "Image/1"));
        info("Platform/ML505/FPGA: " & jsonGetString(JSONFileContent, "Platform/ML505/FPGA"));
        info("Platform/KC705/IIC/0/Devices/0/Name: " & jsonGetString(JSONFileContent, "Platform/KC705/IIC/0/Devices/0/Name"));
      end if;
    end loop;
    test_runner_cleanup(runner);
    wait;
  end process;
end architecture;
