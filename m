From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Oct 2010 19:23:21 +0000
Subject: Re: [lm-sensors] Compiling 3.2.0
Message-Id: <20101013212321.0cdd9970@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <60165478.20101013180541@mtu-net.ru>
In-Reply-To: <60165478.20101013180541@mtu-net.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrey,

On Wed, 13 Oct 2010 18:05:41 +0400, Andrey Repin wrote:
> I've a kind of an issue. It was true for 3.1.2 and now for 3.2.0.
> Programs building fine with exception of /prog/init/sensord.init - after
> compilation, it retain all the @tokens@ typical for pre-configure scripts. But
> as far as I can tell, the compilation does not involve configure process.
> So, how to get past this?

sensord.init isn't installed by default. It is there as legacy
documentation, and isn't actively maintained. As the header comment
says: "tested for RedHat 7.2 only". It even looks for odd module
aliases which I have never seen before, so this must pre-date my
involvement in the project, 8 years ago. So I'm pretty certain it
no longer works.

So I suggest that you simply forget about sensord.init. If nobody
objects, I'd even vote for deleting this old file to prevent further
confusion.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
