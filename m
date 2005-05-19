From: svec@nostromo.cz (svec svatopluk)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: lm_sensors mkpatch problem
Message-Id: <5.0.0.25.2.20011109161639.0229e4b0@jlabs.ti.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


hello lm_sensors guys,

i had experienced problem with making diff file for lm_sensors - drivers

(i2c part just maked diff file & kernel patch OK)

it showed me this message :

"failed to make Makefile patch, at line 426 , contact authors"


my configuration :

redhat linux 7.2 , kernel source version : 2.4.9-13 (fresh copy, no 
patches, just deleted source tree and rpm-ed 
file  "kernel-source-2.4.9-13.i386.rpm" )

- at first, i selected and compilled i2c and sensors from this kernel, but 
then i decided to download your sensors and build them into the kernel



good bye for now

svec svatopluk
czech republic
