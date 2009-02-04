From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 04 Feb 2009 21:53:29 +0000
Subject: [lm-sensors] [RFC 0/4] Add support for multiple configuration files
Message-Id: <20090204225329.0ebb0fef@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here is a proposal to enable support for multiple configuration files
to libsensors. The original idea was to extend the configuration file
syntax to allow file inclusion [1]. I have chosen a different approach
similar to what many other tools to, that is: a directory where users
can put configuration files. This seems more flexible to me.

[1] http://www.lm-sensors.org/ticket/2174

In practice, this means that users (or configuration tools) can add
libsensors configuration files to directory /etc/sensors.d, and they
are processed exactly the same way as /etc/sensors.conf is. One clear
potential use of this mechanism is a tool which would identify the
mainboard and drop a mainboard-specific configuration file
to /etc/sensors.d, either downloaded from the network or copied from
some /usr/share/libsensors directory.

This patch set is composed of 3 preliminary patches which reorganize
the libsensors initialization code with no feature changes, and a 4th
patch implementing the new feature.

One important thing to notice is that this change makes bus statements
configuration file specific. While it would be possible to let bus
statements run from one configuration file to the next, it could result
in collisions when dropping several files into /etc/sensors.d (for
example one for the mainboard and one for the graphics adapter.) OTOH,
this also enforces the fact that bus statements have no effect beyond
configuration files, which basically means it will be difficult, if not
impossible, to implement ticket #2238 [2]. While we have been living
without it so far, there have been some discussions lately about the
effects of module load order and this ticket was one possible partial
solution to this problem.

[2] http://www.lm-sensors.org/ticket/2238

Another issue which still needs to be solved is the reporting of parse
errors. At the moment, the parse errors are identified by only a line
number, based on the assumption that there is only one possible
configuration file so the user knows where to look. Now that libsensors
supports several configuration files, the error messages become more
difficult to read. I will look into this later. I fear that a clean
solution would require an API change though.

I would welcome comments, reviews and test reports on these patches.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
