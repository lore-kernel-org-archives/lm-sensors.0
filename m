From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 03 Apr 2007 05:46:59 +0000
Subject: Re: [lm-sensors] Asus smbus mux
Message-Id: <20070403074659.1c34491d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3df49b7b0704011722q1201063eh37253910ddb1e004@mail.gmail.com>
In-Reply-To: <3df49b7b0704011722q1201063eh37253910ddb1e004@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2 Apr 2007 19:26:20 +0200, RusH wrote:
> On 4/2/07, Jean Delvare wrote:
> > We cannot do that for all motherboards out there, in particular we
> > don't want to do that just to give access to some SPD EEPROMs, the cost
> > is too high for the thin benefit.
> 
> I understand. Arent clock generators on the smbus too? Not that acces
> to them is important or particularly safe.

They are, but we don't need nor want to touch them. The devices most
frequently found on the SMBus are SPD EEPROMs, clock chips and hardware
monitoring chips. Of these, only hardware monitoring chips are worth
the effort IMHO until we get a more generic mux handling infrastructure.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
