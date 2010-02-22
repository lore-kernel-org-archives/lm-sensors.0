From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Feb 2010 20:43:09 +0000
Subject: Re: [lm-sensors] [RFC PATCH v1 0/2] Add the sensors-config tool
Message-Id: <20100222214309.37ef361c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100219193821.GA1917@andre-laptop>
In-Reply-To: <20100219193821.GA1917@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 22 Feb 2010 21:28:40 +0100, Andre Prendel wrote:
> On Mon, Feb 22, 2010 at 10:04:17AM +0100, Hans de Goede wrote:
> > I think using the exact same names as under /sys/class/dmi/id
> > is a good idea.
> 
> Ok, after Jean's email I think we should do so. But I don't like
> spaces and some other special chars in filenames. Maybe we can replace
> this chars by underscores. But then the matching stuff isn't so easy.

I don't like spaces either and I'm all for replacing them (and other
funky chars) by underscores. "tr" is your friend :) then sed to strip
the duplicates.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
