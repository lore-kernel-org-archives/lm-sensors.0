From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: i801 bus problems
Message-Id: <4137A0AE.8020106@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I may have jumped the gun a bit.  It looks like i801 is working but some 
client chips are not responding or are missing?


Phil

Philip Edelbrock wrote:
> 
> You may need to turn something on in the Bios for the SMBus interface to 
> be properly set up at boot-time?  A relevent snippet from the i2c-i801 doc:
> [...]
