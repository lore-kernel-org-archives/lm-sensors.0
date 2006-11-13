From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 13 Nov 2006 21:04:57 +0000
Subject: [lm-sensors] w83627ehf informations
Message-Id: <20061113220457.b5c9b35b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1163284779.5555.34.camel@armageddon>
In-Reply-To: <1163284779.5555.34.camel@armageddon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David, Torsten,

On Mon, 13 Nov 2006 10:46:55 -0700, David Hubbard wrote:
> Hi Torsten,
> 
> I don't know which kernel the 2.6.18-mm2 patch applies against. I
> wonder if someone on the lm-sensors list knows more about this?

The 2.6.18-mm2 patch applies on top of 2.6.18, but I wouldn't recommend
using an old -mm kernel.

> On 11/13/06, torsten goroll <2crazy4you at gmx.de> wrote:
> > Ok, I will try Kernel 2.6.18.2 with the mm2 patch.
> > This seems to be the correct one. Alternativly I could try .19-rc4,
> > what would might be the best choice? Is the driver in the release
> > version more recent?

The driver in 2.6.19-rcX has one more fix from Rudolf Marek for fan5
detection, that wasn't present in 2.6.18-mmX.

I suggest that you try 2.6.19-rc5 (or even 2.6.19-rc5-git2 or whatever
is the latest Linus' tree when you fetch it.) It's probably the most
stable kernel tree you can hope for which will include the support you
need.

Note that you'll also need lm_sensors 2.10.1 for user-space support.

-- 
Jean Delvare

