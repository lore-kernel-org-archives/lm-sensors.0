From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 27 Dec 2006 11:16:06 +0000
Subject: [lm-sensors] #2143: Can't detect sensors on Asus DSBF-D
Message-Id: <20061227121606.6a2a628f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <001201c7294b$fc1acf90$35fe1fac@ocg.ca>
In-Reply-To: <001201c7294b$fc1acf90$35fe1fac@ocg.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michelle,

On Tue, 26 Dec 2006 19:14:33 -0500, Michelle Dupuis wrote:
> I applied the W83793 driver patch to 2.6.18 kernel, and it worked great.  My
> asus dsbf-d mobo is now reading fan and temp settings.  (I get one mystery
> fan reading - since nothing is plugged in there - but that's ok since I just
> ignore it).

This shouldn't happen. Can you please provide the complete outout of
"sensors", including this mystery fan reading? Is it stable or changing
all the time? The driver is new, maybe it can be improved.

-- 
Jean Delvare

