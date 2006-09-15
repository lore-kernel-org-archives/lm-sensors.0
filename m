From: david.c.hubbard@gmail.com (David Hubbard)
Date: Fri, 15 Sep 2006 18:18:27 +0000
Subject: [lm-sensors] [RFC-patch 0/3] SuperIO locks coordinator
Message-Id: <4dfa50520609151118s65a980b4td143a9fbbfeb1798@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4508FF2F.5020504@gmail.com>
In-Reply-To: <4508FF2F.5020504@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> BTW, are the idle/activate sequences doc'd in your datasheet ?
> I ask this cuz pc87360 has a superio-exit defined (and used), but no
> superio-enter(),
> and I couldnt find the idle/activate sequences docd in my datasheet.
> With the long history of copy & modify in these drivers, its possible
> that some cargo-cult features were inadvertently carried forward,
> esp when drivers are written w/o actually having the hardare.
>
> Could you disable your superio-enter(), and see if that breaks the
> functionality ?

I'll do that and let you know how it goes. I suspect that the BIOS
initializes the w83627ehf correctly, and so the superio-enter and
-exit that are used may not be required...except during detection. The
w83627ehf is mapped into ISA I/O space (probably by the BIOS). So I'll
test my theory and get back to you soon.

David

