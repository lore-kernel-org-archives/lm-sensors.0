From: lists@edeca.net (David Cannings)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: w83697hf -12v readings
Message-Id: <41D28D44.5080900@edeca.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The readings from 'sensors' under the section w83697hf-isa-0290 show the
following:

-12V:      +2.22 V  (min = -13.16 V, max = -10.77 V)       ALARM
-5V:       +0.60 V  (min =  -5.23 V, max =  -4.73 V)       ALARM

I would hope this is incorrect!  Is it possible to fix the values so
they display correctly?  All of the other output seems fine and
correlates with either the ACPI thermal zone, BIOS readings, etc.

The chips on board are the SIS 961 and a Winbond W83697HF.

David
