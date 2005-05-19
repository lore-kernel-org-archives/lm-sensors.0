From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: Read word
Message-Id: <3F9483AB.F5318810@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031013214150.4d6a92a9.khali@linux-fr.org>
In-Reply-To: <20031013214150.4d6a92a9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sounds harmless to me
(famous last words...)

Jean Delvare wrote:
> 
> Hi all,
> 
> Are there negative side effects trying to read an I2C chip register in
> byte mode while it is supposed to be read in word mode? I'm thinking of
> using this to enhance our LM75 detection. Since the LM75 returns the
> words high byte first, while other chips usually return low byte first,
> we could try and read registers 0, 2 and 3 in byte mode and make sure
> that the byte returned matches the high byte, not the low byte, of the
> words we previously read.
> 
> Just a thought, comments welcome.
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
