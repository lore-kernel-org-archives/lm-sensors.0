From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 09 Feb 2007 17:20:46 +0000
Subject: [lm-sensors] problem with i801
Message-Id: <20070209182046.ba50504d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4586BC72.5080308@ctm.ulpgc.es>
In-Reply-To: <4586BC72.5080308@ctm.ulpgc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 09 Feb 2007 16:52:37 +0000, Eduardo Suarez wrote:
> I don't understand how sensors work. Is there a way to tell not to test
> the nvidia?

Of course:

rmmod nvidia

-- 
Jean Delvare

