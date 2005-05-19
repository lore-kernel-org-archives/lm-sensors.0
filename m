From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: LM Sensors on SuperMicro??
Message-Id: <1078216707.404448030dc89@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040302024423.83126.qmail@web21004.mail.yahoo.com>
In-Reply-To: <20040302024423.83126.qmail@web21004.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please reply to the list, not to me]

Quoting Ravichandra Moka <ravichandra22us@yahoo.com>:

> 1. I got LM sensors worked on ASUS and GIGABYTE MB's. I am trying to
> make it work on SuperMicro but I cudn't.
>  
> 2. It displays an error such as "Segmentation Fault" when I run an
> executable called "superodoctor"
>  
> 3. I got superodoctor tarball from SuperMicro's CD (when I bought
> it)

Well, so far there's nothing we can do. See with them.

> 4. I was wondering whethere I could avoid using superodoctor and make
> use of LM sensors instead.
>  
> Please let me know if any one ever worked to sense SuperMicro's
> health values.

There is no reason it wouldn't work. See Alex Van Kaam's motherboards
database here:
http://mbm.livewiredev.com/comp/supermicro.html
There are a lot of Supermicro motherboards with standard hardware
monitoring chips (basically, Alex' MBM and lm_sensors support the same
range of chips).

So, just install lm_sensors on your new system and run sensors-detect.
It'll tell you what you have and which drivers you need to use.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
