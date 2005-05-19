From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: Conversion guide for i2c chip drivers
Message-Id: <20030928004718.GE5084@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030927122451.191bb291.khali@linux-fr.org>
In-Reply-To: <20030927122451.191bb291.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Oops, forgot one:

> * [Client data] Get rid of sysctl_id. Use standard names for register
>   values (for example, temp becomes temp_input, temp_os becomes
>   temp_max).

Use the file names specified in Documentation/i2c/sysfs-interface for
the individual files.  Also convert the units these files read and write
to the specified ones.

If you need to add a new type of file, please discuss it on the sensors
mailing by providing a patch to the Documentation/i2c/sysfs-interface
file.

thanks,

greg k-h
