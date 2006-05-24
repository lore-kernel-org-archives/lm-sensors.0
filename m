From: lvanek@charter.net (Laurence Vanek)
Date: Wed, 24 May 2006 03:07:11 +0000
Subject: [lm-sensors] Fedora Core 5 latest kernel breaks lmsensors on Asus
Message-Id: <4473CDDF.1070409@charter.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Upon updating to the latest kernel (2.6.16-1.2122_FC5) & rebooting I 
find that I no longer have lmsensors.  /var/log/messages gives this in 
the suspect area:

=====
.
.
.

May 22 11:42:42 localhost kernel: i2c_adapter i2c-0: SMBus Quick command 
not supported, can't probe for chips
May 22 11:42:42 localhost kernel: i2c_adapter i2c-1: SMBus Quick command 
not supported, can't probe for chips
May 22 11:42:42 localhost kernel: i2c_adapter i2c-2: SMBus Quick command 
not supported, can't probe for chips
.
.
.
====
Responses I got from the Fedora mail-list seemed to indicate that this 
is specific to Asus M/B's.  Mine is an Asus P4B533.  I have been using 
lmsensors on this system for several years thru many Fedora kernels.  
The previous kernel (kernel-2.6.16-1.2111_FC5) & kernels prior work fine.

I get the impression that since a small population is having the issue 
no effort will be made on the kernel side.

Any advice is welcome.

