From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: libsensors for linux 2.6
Message-Id: <3FB8357D.E8B328E8@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031116144447.6ac271ca.khali@linux-fr.org>
In-Reply-To: <20031116144447.6ac271ca.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

looks fine to me...
temp_min1 is 3rd from last...

# cat temp*
3200
3650
0
12700
6000
6000
6000
5000
5000
# echo 7000 > temp_min1
# cat temp*
3200
3650
0
12700
6000
6000
7000
5000
5000


Jean Delvare wrote:
> 
> > I'm running test8 and they don't look swapped to me.
> >
> > # for i in temp*
> > > do
> > > echo $i
> > > cat $i
> > > done
> > temp_input1
> > 3100
> > temp_input2
> > 3750
> > temp_input3
> > 0
> > temp_max1
> > 12700
> > temp_max2
> > 6000
> > temp_max3
> > 6000
> > temp_min1
> > 6000
> > temp_min2
> > 5000
> > temp_min3
> > 5000
> 
> I misexpressed myself. What I should have said is: *writing* to over and hystsresis values is swapped. Try writing to temp_min1, I'm quite sure that temp_max1 value will change instead.
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
