From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: smart HDD
Message-Id: <3F1C9896.7070704@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030721154832.43dd6564.khali@linux-fr.org>
In-Reply-To: <20030721154832.43dd6564.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here you go.
It uses large parts of the program 'hddtemp'.
I copied 'sensors' to add this early in the year.
It would have to be merged back.

Installation instructions:
- untar from top of lm_sensors2
- add prog/sensorshd to SRCDIRS in top level Makefile
- run 'make' as usual.
- copy prog/sensorshd/hddtemp.db to /etc

Running:
- binary is prog/sensorshd/sensors
- you have to run it as root to get the hd temp too
- If your drive doesn't support SMART it clogs up your dmesg
- Your drive has to be in hddtemp.db


Jean Delvare wrote:
>>I've implemented HDD temperature in 'sensors', I never checked it in.
>>It's pretty neat. 
>>
>>I never checked it in because it has some problems, has to be run as
>>root, and (as you pointed out) it's debatable what the relationship is
>>to our project. It's definitely sensor-related but not i2c-related.
>>
>>If you want I can email my version to the list.
> 
> 
> I'm interested, send it at least to me :) Thanks.
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensorshd.tar.gz
Type: application/gzip
Size: 55892 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030721/1039462f/sensorshd.tar.bin
