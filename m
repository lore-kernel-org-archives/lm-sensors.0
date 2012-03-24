From: "Michael Walle" <michael@walle.cc>
Date: Sat, 24 Mar 2012 00:03:34 +0000
Subject: [lm-sensors] bus names and multiple adapters of the same kind
Message-Id: <201203240103.34050.michael@walle.cc>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

the busses for the chip statements seems to be compared by their names. Eg. i 
do have two I2C busses, both uses the same driver. A sensors --bus-list give 
me:

bus "i2c-0" "IBM IIC"
bus "i2c-1" "IBM IIC"

If i have two i2c sensors at the same i2c address on these two busses, the 
chip statements always match the first one:


chip "adt7411-i2c-0-48"

    label in0 "Test"
    
chip "adt7411-i2c-1-48"

    label in1 "Foobar"


sensors now only replaces the labels of adt7411-i2c-0-48, but for both in0 and 
in1. Eg:

# sensors
adt7411-i2c-0-48
Adapter: IBM IIC
Test:         +3.33 V  
Foobar:       +0.31 V  
in2:          +0.00 V
[..]

adt7411-i2c-1-48
Adapter: IBM IIC
in0:          +3.33 V  
in1:          +1.92 V  
in2:          +2.13 V  
[..]


The manpage states the following
  A bus statement binds the description of an I2C or SMBus adapter to a bus
  number. This makes it possible to refer to an adapter in the configuration
  file, independent of the actual correspondence of bus numbers and actual
  adapters (which may change from moment to moment).


Unfortunately, this doesn't work if there are two adapters with the same name 
as on most SoCs :(

-- 
michael

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
