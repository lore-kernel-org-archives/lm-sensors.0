From: pengi.films@gmail.com (Joe Friedrichsen)
Date: Sun, 28 Jan 2007 19:40:58 +0000
Subject: [lm-sensors] VT1211 at 0x4e/0x4f (sensors: addressed to
Message-Id: <ecd00e6d0701281140s5ff52cbl17f4f86c08b08420@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 1/28/07, Jean Delvare - khali at linux-fr.org wrote:
> Hi Juerg,
>
> As almost all Super-I/O chips, the VT1211 can live at two different
> address pairs, 0x2e/0x2f or 0x4e/0x4f. The vt1211 driver only supports
> the former at the moment. Some systems use the latter though:
> http://www.lm-sensors.org/ticket/2149

And I'm the one who added that ticket. If you need me to test things,
please let me know.

Joe

