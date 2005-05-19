From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: W83791 (was: How to activate the SMBus on P4B533E/ICH4?)
Message-Id: <3D178EB6.A0571BA1@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.31.0206221506270.11389-100000@klaus.dns2go.com>
In-Reply-To: <Pine.LNX.4.31.0206221506270.11389-100000@klaus.dns2go.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

No, as shown on our new drivers page.
If you have a board with a 791 on it that would be great - let us know.
As the 791 has SMBus 2.0 support (which I'm working on in i2c-core, etc.)
there are some interesting things we can test.

Klaus Woltereck wrote:
>
> W83791:
> 
> I just added some rudimentary support for the W83791SD in the w83781d
> module.
> 
> Before I go on, I would like to know if anyone already done this?
> 
> If so, please me know!
