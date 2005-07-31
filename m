From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 31 Jul 2005 19:14:55 +0000
Subject: [lm-sensors] Support for Winbond W83687THF in Lm_sensors-2.9.1
Message-Id: <20050731191420.1b0ddf7f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050726214252.85202.qmail@web31008.mail.mud.yahoo.com>
In-Reply-To: <20050726214252.85202.qmail@web31008.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hugo,

> A little while ago Jean Delvare helped me to set up
> support for this in 2.6.x.
> 
> I am now trying to get it to work in 2.4.31. But the
> w83627hf modules in 2.6.x and 2.9.1 are very
> different.
> 
> I attach a patch I attempted. The module loads but no
> sensors found.
> 
> Could someone with more knowledge than I take a look
> at this please?

Your patch looks almost correct to me, I think you simply forgot to
update this part:

	if (kind = w83627hf) {
		type_name = "w83627hf";
		client_name = "W83627HF chip";
	} else if (kind = w83627thf) {
		type_name = "w83627thf";
		client_name = "W83627THF chip";
	} else if (kind = w83697hf) {
		type_name = "w83697hf";
		client_name = "W83697HF chip";
	} else if (kind = w83637hf) {
		type_name = "w83637hf";
		client_name = "W83637HF chip";
	} else {
		goto ERROR1;
	}


You need another "else if" statement for the W83687THF here, and it
should be OK after that.

Let us know :)

-- 
Jean Delvare
