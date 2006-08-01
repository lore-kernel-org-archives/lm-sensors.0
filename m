From: drasko.draskovic@gmail.com (Drasko Draskovic)
Date: Tue, 01 Aug 2006 14:04:49 +0000
Subject: [lm-sensors] I2C for uCLinux on ARM926EJ (with AMBA bus)
Message-Id: <5ec3d7930608010704g39ff5710u35686e708c152a7d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi. I am working on a custom design that is based on ARM926EJ and AMBA
bus. OS of choice is uCLinux, patched with RTAI for RT performance. I
have to implement now I2C support, but looking at the existing driver
things seem a bit unclear for me.

Here is what I unserstood:
i2c-core.c is independent of the bus and is kernel module. This should
be working. But  what about AMBA bus? Is it supported? Is this file for
support of AMBA located in 'busses' directory? What are algos files? As
I undersand, these are bus dependent. Is AMBA supported by these?

If there are not, does anyone have idea how these can be written?

How can a proper working of I2C be tested? Can some dummy I2C
peripheral be created in Linux?

Any information will be more than helpful.

Thanks,
-- 
Drasko DRASKOVIC

Software Developer
Elsys-DESIGN
Belgrade, Serbia
Tel. +381.11.311.5252
Fax. +381.11.311.5251
www.elsys-design.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060801/a2a5d0e8/attachment.html 
