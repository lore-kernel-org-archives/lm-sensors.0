From: brsmith4@ritchie.acomp.usf.edu (Brian Smith)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: Problems with Gigabyte GA-7VTXE
Message-Id: <1030131854.1696.6.camel@saturn.sol>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I am trying to get lm sensors to work on a bunch of identical cluster
nodes.  I am having great difficulty trying to determine which modules I
should use for this motherboard.  There is very little documentation.  I
read on thread where the guy claimed to get it working and I followed
his commands but it did not work (he had the same mobo as I).  So far, I
have been able to get some readout, although highly erroneous, from the
following commands:

modprobe i2c-core
modprobe i2c-proc
modprobe i2c-dev
modprobe i2c-isa
modprobe lm78

I am running RedHat linux version 7.3, with the stock 2.4.18 kernel that
is shipped.  I upgraded the rpm from 2.6.0 to 2.6.1.  I ran the
sensors-detect program and it told me I had that national semiconductors
device and told me to use module lm78.  I need some help with this as
hardware monitoring will be an integral part of keeping our cluster up
and running.  Any help will be appreciated.

-- 
Brian R. Smith
Academic Computing
University of South Florida
