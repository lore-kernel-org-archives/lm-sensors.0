From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: ADM1023 vs. ADM1021A
Message-Id: <3F05CFAD.8030203@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030704104521.242e47b5.khali@linux-fr.org>
In-Reply-To: <20030704104521.242e47b5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you can write and read a limit register that isn't on the 1021.
To be low-impact you could read the low byte, change the lsb, write it back,
then read it back...
Although if it's really the same die then that won't work...
You can also ask our Analog Devices contact mary.burke _at_ analog.com

Jean Delvare wrote:
> Reading the ADM1021A and ADM1023 datasheets, it seems to me that there
> is no way to distinguish  between these two chips. Am I right? Both are
> treated as ADM1023 (high precision) in our code, what would happen if an
> ADM1021A (low precision) was really there? I'd say that if should work
> (if ADM1021A has all the ADM1023 high-resolution registers set to zero
> and read accesses don't fail) but I'm not really sure.
> 
