CREATE TABLE `layoffs_staging7` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging7
where row_num > 1 ;

insert layoffs_staging7
select *,
ROW_NUMBER () OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions)
as row_num
from layoffs_staging3;

delete
from layoffs_staging7
where row_num > 1 ;

select *
from layoffs_staging7 ;

SELECT *
FROM layoffs_staging7 
where industry <> '' and industry is not null;

SELECT *
FROM layoffs_staging7 
where industry = '' OR industry is null;

SELECT *
FROM layoffs_staging7 
where company = 'Airbnb';

update layoffs_staging7
set industry = null
where industry = '' ;



SELECT *
FROM layoffs_staging7 t1 
join layoffs_staging7 t2
on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null ;

update layoffs_staging7 t1
join layoffs_staging7 t2
on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

select *
FROM layoffs_staging7
where total_laid_off is null
and percentage_laid_off is null ;

alter table layoffs_staging7
drop column row_num ;

select *
from layoffs_staging7 ;