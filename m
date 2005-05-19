From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: Query: using parport to send 24-bit serial clock and data?
Message-Id: <58md61951tg90pi29oh5fb0853rbrgjmg8@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <hbn5619oiuenbrvpf8sj49fh89kb1fj34s@4ax.com>
In-Reply-To: <hbn5619oiuenbrvpf8sj49fh89kb1fj34s@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,
On Wed, 20 Apr 2005 21:29:52 +0200, Rudolf Marek <r.marek@sh.cvut.cz> wrote:
>
>> So which low-level driver would you suggest as a starting point?
>
>I would create very own char device driver and start using portions from i2c-pport.
>I would rip all i2c specific code...
>for 2.6.x it can be found at http://assembler.cz/download/i2cpport26.tar.gz

Thank you, on the back burner now 'cos my friend just bought a USB 
FM radio, has it working on linux.

Friend is happy, and I get to put this project off until after I've 
fixed hardware monitoring and CPU fan control in my machines under 
linux.

Cheers,
Grant.
