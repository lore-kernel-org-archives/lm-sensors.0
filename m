From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 31 Mar 2007 12:45:13 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <20070331144513.5325bd61.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ed,

On Thu, 29 Mar 2007 11:00:32 +0100, Ed Lucas wrote:
> I have also added a "tags" field in which you can add a fixed set of 
> tags to describe the file: so far I have thought of "broken", 
> "experimental" and "beta". Perhaps this goes some way towards emulating 
> your "unsure" database flag, Ivo? I went for the name "tags" rather than 
> "status" so that other info could be added with minimal api changes. 
> This is more for my sensors overlay work, so feel free to disregard it 
> if it doesn't fit your goals.

Random idea: we could add an architecture tag to configuration files.
There's no point in installing files for x86 motherboards on an x86_64
distribution for example. This would allow distributions to split the
configuration files to multiple packages and only includes the ones
they want.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
