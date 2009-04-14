From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 14 Apr 2009 08:52:35 +0000
Subject: Re: [lm-sensors] MSI 945GC with Intel Atom 330,
Message-Id: <20090414105235.248f144c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <000601c9b45b$3a5ee150$af1ca3f0$@com>
In-Reply-To: <000601c9b45b$3a5ee150$af1ca3f0$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 3 Apr 2009 22:53:43 +1000, Cayden wrote:
> An unknown sensor is detected when sensors detect is run. 
> 
> Found unknown chip with ID 0x0541 is the only real output I get. 
> (...)
> Sensors Detect Output:
> 
> # sensors-detect revision 5291 (2008-06-23 23:40:46 -0700)

This is old. Try the latest version of the script:
http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect

It will tell you what your chip is. 

> Kernel :2.6.18
> 
> Lm_sensors : 2.10.7-4

Whether this relatively old kernel will support it or not is another
story.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
