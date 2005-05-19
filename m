From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: negative voltages
Message-Id: <20040202222135.70e5bdf8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075721644.401e35ac8e6fc@imp.gcu.info>
In-Reply-To: <1075721644.401e35ac8e6fc@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I've made the necessary fixes to libsensors. This is the way that
requires the less changes and it doesn't break 2.4 drivers so I suggest
we stick to it for now.

Tested to work with my AS99127F rev.1 (driver w83781d). More testers
welcome.

That said and done, the question is still opened how we will handle the
negative voltage limits in libsensors2. Since I believe we want a
chip-independant library, which means that some chips would have min <
max and some others would have the contrary, and userspace apps would
have to cope with it. I don't really see major problems doing this.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
