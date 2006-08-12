From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 12 Aug 2006 19:37:44 +0000
Subject: [lm-sensors] Thinkpads still not supported?
Message-Id: <20060812213744.537a63d3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20060811T155741-190@post.gmane.org>
In-Reply-To: <loom.20060811T155741-190@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David,

> 185 degrees Farenheit at idle doesn't worry you?  Well, that's
> good to know.

Degrees Fahrenheit don't mean anything to me ;)

> > Make sure your system won't load related drivers for you at boot
> > time.
> 
> Like what?

Any module with "i2c" in its name, and the "eeprom" module.

-- 
Jean Delvare

