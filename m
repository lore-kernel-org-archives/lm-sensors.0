From: RaphaelD@tyan.com (Raphael Deng)
Date: Thu, 05 Jan 2006 21:27:59 +0000
Subject: [lm-sensors] the issue about config bus and proc bus number
Message-Id: <3174569B9743D511922F00A0C94314230D826E12@TYANWEB>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

 

I come from Tyan Computer. Right now, I'm doing the configuration file for
Tyan S4882D and S4881. I used the SuSE Professional 10.0, kernel is 2.6.13.
lm-sensor version is 2.9.1.

 

As both of these two board, have PCA9556 multiplexer as I2C Switch, I loaded
the dirver "i2c-amd756-s4882", then I can see all the busses and hwm chips.

The issue is I could not make configured bus number in configuration files
match the proc ones.

 

Following is claimed bus in my configuration file, actually, I checked the
source code, it should be same in proc.

 

bus "i2c-0" "SMBus AMD8111 adapter at c0e0" "Unavailable from sysfs"

bus "i2c-1" "SMBus 8111 adapter (CPU0)" "Unavailable from sysfs"

bus "i2c-2" "SMBus 8111 adapter (CPU1)" "Unavailable from sysfs"

bus "i2c-3" "SMBus 8111 adapter (CPU2)" "Unavailable from sysfs"

bus "i2c-4" "SMBus 8111 adapter (CPU3)" "Unavailable from sysfs"

 

(btw, I don't know why the algorithm is "Unavailable from sysfs", as source
code, it should be "Non-I2C SMBus adapter", but after traced the code, I got
the former.)

 

I found after calling function "sensors_substitute_chip" in file
"lib\data.c", the chip bus will be changed,

 

int sensors_substitute_chip(sensors_chip_name *name,int lineno)

{

  int i,j;

  for (i = 0; i < sensors_config_busses_count; i++)

    if (sensors_config_busses[i].number = name->bus)

      break;

 

  if (i = sensors_config_busses_count) {

    sensors_parse_error("Undeclared i2c bus referenced",lineno);

    name->bus = sensors_proc_bus_count;

    return -SENSORS_ERR_BUS_NAME;

  }

 

  for (j = 0; j < sensors_proc_bus_count; j++) {

    if (!strcmp(sensors_config_busses[i].adapter,

                sensors_proc_bus[j].adapter) &&

        !strcmp(sensors_config_busses[i].algorithm,

                sensors_proc_bus[j].algorithm)) 

      break;

  }

 

  /* Well, if we did not find anything, j = sensors_proc_bus_count; so if

     we set this chip's bus number to j, it will never be matched. Good. */

name->bus = j;

// I don't understand why you need change the bus number to j, in my
opinion, here should be "name->bus = sensors_proc_bus[j].bus"

// actually, I tried to dump all the sensors_proc_bus, it's like this:

//0:bus number 4 is (SMBus 8111 adapter (CPU3))(Unavailable from sysfs)

//1:bus number 3 is (SMBus 8111 adapter (CPU2))(Unavailable from sysfs)

//2:bus number2 is (SMBus 8111 adapter (CPU1))(Unavailable from sysfs)

//3:bus number 1 is (SMBus 8111 adapter (CPU0))(Unavailable from sysfs)

//4:bus number 0 is (SMBus AMD8111 adapter at c0e0)(Unavailable from sysfs)

//5:bus number -1 is (ISA main adapter)(ISA bus algorithm)

// it's obviously, the bus number is not equal to the array position j.

  return 0;

}

Best Regards

Raphael Deng

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060105/1cd8e63f/attachment.html
