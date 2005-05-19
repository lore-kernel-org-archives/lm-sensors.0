From: sascha@akv-soft.de (Sascha Volkenandt)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: EEPROM write support
Message-Id: <200307231630.51562.sascha@akv-soft.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307221931.02558.sascha@akv-soft.de>
In-Reply-To: <200307221931.02558.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

At Mittwoch, 23. Juli 2003 02:40 Philip Edelbrock wrote:
> I thought we did have write support as a compile-time option (via a
> define or something).  I thought Mark did that a long time ago?  I could
> be imagining things.  (Or maybe we moved that to user-space only?)

Well in the latest cvs (which I use for a regular base now, updated at least 
once a week), everything that there _has been_ write support ist commented 
out (/* No write support (yet) */). I was mainly wandering why it said 
"yet".

@Phil, Jean: You don't need to CC me anymore, I'm subscribed :-)

Greetings,
Sascha
