From: tero.saarni@gmail.com (Tero Saarni)
Date: Sun, 21 Aug 2005 19:59:30 +0000
Subject: [lm-sensors] SMBus not detected on SiS 964 south bridge
Message-Id: <ad348feb050821105869e11815@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <dctehc$g25$2@sea.gmane.org>
In-Reply-To: <dctehc$g25$2@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On 8/21/05, Rudolf Marek <r.marek@sh.cvut.cz> wrote:
> And can you read values from it87?
> 
> modprobe i2c-isa
> modprobe it87

I tried loading i2c_isa and it87 (without any parameters) but isadump 
returns all 0xFF's and /proc/ioports doesn't show anything in 0x290 -
0x297 address range.  i2cdump obviously still fails since there's no
smbus detected in the system.

Best regards,
Tero
