From: lists@edeca.net (David Cannings)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: w83697hf -12v readings
Message-Id: <41D2979A.6090503@edeca.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D28D44.5080900@edeca.net>
In-Reply-To: <41D28D44.5080900@edeca.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi David,
>> The readings from 'sensors' under the section w83697hf-isa-0290
>> show the following:
>> -12V:      +2.22 V  (min = -13.16 V, max = -10.77 V)       ALARM 
>> -5V:       +0.60 V  (min =  -5.23 V, max =  -4.73 V)       ALARM
>> I would hope this is incorrect!  Is it possible to fix the values
>> so they display correctly?  All of the other output seems fine and 
>> correlates with either the ACPI thermal zone, BIOS readings, etc.
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section-4_002e6
> Does the BIOS display values for -12V and -5V? If it does, what are 
> they?

No, it does not, I hadn't noticed this.  It does display values for
Vdimm and Vio though which aren't in sensors.

>> The chips on board are the SIS 961 and a Winbond W83697HF.
> What motherboard is it exactly?

An Epox 4SDM2+.  Thanks for the FAQ reference, I've never had a new
enough board that doesn't show the -12v and -5v lines until now.  I've
simply ignored the two sensors in the configuration file, for now.

David
