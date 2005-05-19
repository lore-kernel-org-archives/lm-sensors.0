From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: Ticket #: 1533 / Cant use Sensors -s
Message-Id: <20040124174428.6518ed28.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1074957554.5412.3.camel@Technetium.pse.local>
In-Reply-To: <1074957554.5412.3.camel@Technetium.pse.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Oh right :). Here is the output of all files, and permissions.
> 
> -rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 alarms
> (...)
> Strange thing is that all is 777  :/ 

Yes, strange is the correct word. Even "name" and "power" are, so I
think this excludes any driver-specific cause. I'd like you to move
around in /sys/bus/i2c and see if each other file/dir has 777
permissions. Also, see in the rest of /sys if there are non-i2c-related
directories with the same anomaly.

Second, try to write a value to an ordinarily-writable i2c file such as
temp_max1. Echo 61000 to it, and cat it to check if the write was
successful.

Third, could you reproduce the problem with a non-mm kernel (2.6.2-rc1
for example).

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
