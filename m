From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: libsensors for linux 2.6
Message-Id: <3FBAEB5E.B48DEF34@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031116144447.6ac271ca.khali@linux-fr.org>
In-Reply-To: <20031116144447.6ac271ca.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> 
> Mark,
> 
> > looks fine to me...
> > temp_min1 is 3rd from last...
> 
> OK, actually the variables are swapped everywhere (for temp1), so
> although it is a mess from a developer's point of view, it doesn't hurt
> the user.
> 
> Still I would bet that temp2 and temp3 suffer from the problem I
> suspected. Writing to temp_max2 would probably change temp_min2's value
> instead. Could you confirm?
> 

correct, that's what it does, max and min are swapped for 2 and 3.
