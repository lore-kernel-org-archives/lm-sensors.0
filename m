From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: voodoo3 3000, Fedora 2, lm_sensors, and tv-out
Message-Id: <4159FE20.1010204@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <4159F327.8080607@edgedesign.us>
In-Reply-To: <4159F327.8080607@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ah, I didn't realize you were trying to do this under a 2.6.x kernel 
(which I think FC2 is, check /proc/version).  We haven't ported the 
bt869 driver over yet.  I think last we heard Berni (b-gruber@gmx.de) 
was working on the port.  Check with him, or use a 2.4.x kernel.

Sorry for the hassle.


Phil

Marion Bates wrote:
> Wow, thanks for replying so fast!
> 
> I found another howto, very similar to Ollila's, here: 
> http://www.perturb.org/content/linux-voodoo3.txt  and at least it gave 
> me some diagnostic commands to run. Here they are, with their output:
> [...]
