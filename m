From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 28 Jul 2006 14:23:57 +0000
Subject: [lm-sensors] Message
Message-Id: <20060728162357.9f0f6de6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1149181308.17368.3.camel@localhost.localdomain>
In-Reply-To: <1149181308.17368.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Enrico,

> that's fine, but downloading and using the latest 2.10.0 version i get
> this message...
> how i have to use this fully-tested code?

You can simply disregard the message, the driver (i2c-piix4) happened
to just work so we did not have to make any change to it. We removed
the message by now, so the next version of lm_sensors (2.10.1) will not
display it.

-- 
Jean Delvare

