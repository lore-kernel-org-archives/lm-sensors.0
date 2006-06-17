From: romain@dolbeau.org (Romain Dolbeau)
Date: Sat, 17 Jun 2006 15:52:09 +0000
Subject: [lm-sensors] Second request to support the 'Analog Devices
Message-Id: <44942529.9040100@dolbeau.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <449408C1.1000307@dolbeau.org>
In-Reply-To: <449408C1.1000307@dolbeau.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Henrique de Moraes Holschuh wrote:

> *If* the chip looks very much like an lm85 or an ATDT7463, *and* you get us
> a full datasheet, we can try to do a spec-sheet-based change to lm85 and
> carefully review it before you try.  At least it shouldn't oops the kernel
> :-) and chances are it will actually work fine.

I don't know how much like previous chip it looks, I was merely
shamelessly quoting Jean Delvare
(see <http://lists.lm-sensors.org/pipermail/lm-sensors/2005-November/014458.html>).

As for the datasheet, the job of looking has already been done for
me by the lm-sensors folk ;-) the 'new drivers' page mentions:

<http://www.analog.com/en/prod/0%2C2877%2CADT7476%2C00.html>

which includes a link to a what is described as a data sheet
(I have zero idea whether it includes the relevant datas,
but it does include 72 pages of technical stuff I understand
nothing about) :

<http://www.analog.com/UploadedFiles/Data_Sheets/402263009ADT7476_a.pdf>

Whenever there's some code to try, I can schedule some downtime
to test (I just can't do it too often).

Thanks for your help,

-- 
Romain Dolbeau
<romain at dolbeau.org>

