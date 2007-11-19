From: "Alan Bennett" <embedded@akb.net>
Date: Mon, 19 Nov 2007 22:14:52 +0000
Subject: [lm-sensors] request for direction
Message-Id: <bfa0697f0711191414v706b92dcu443f87cacbb53d9b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm not sure where to begin looking, but here's what I'd like to do:

I have a device that reads data from userspace and writes it to a
hardware location and then 'burns' that data for a variable amount of
time depending on a i2c temperature sensor.

I have a lookup table that defines my temperature values, I can read
and write the i2c values using the i2c-dev interface, however, I'd
like to have my driver go fetch new i2c values every X number of
cycles and get updated temperatures without having to go out to
user-space and back.  I don't even need the information for a cycle or
2, so speed is not a big requirement

Is there a good example of something like this within the kernel for
reading an i2c device from within a driver?

-Alan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
