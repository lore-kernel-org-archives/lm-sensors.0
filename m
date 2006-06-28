From: paul@lshift.net (Paul Crowley)
Date: Wed, 28 Jun 2006 10:09:48 +0000
Subject: [lm-sensors] A better fan control program
Message-Id: <44A2556C.7070205@lshift.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I know there are several programs out there that adjust your fan speed 
based on temperature readings.  However, I couldn't find one worked well 
on my system, so I wrote my own.   This program takes a very simple 
approach: if the system is too hot, the fans run on maximum power, 
otherwise they run at minimum power.  The reasoning behind this approach 
is explained at length here:

http://www.lshift.net/blog/2006/06/26/thermostat-defeat

and the resulting program, in C, is available here:

http://www.lshift.net/downloads/fankuchen-v0.1.tar.gz

This is now running on my system and I'm very happy with the results.

Should this be the program that ships by default with lm-sensors?  Let 
me know what you think.  Thanks!
-- 
   [][][] Paul Crowley
     [][] LShift Ltd
   []  [] www.lshift.net

