-- Total Cases / Total Deaths
-- Shows the likelihood of dying if you contract covid in your country
SELECT location, date, total_cases, total_deaths,
(total_deaths/total_cases)*100 as death_pct
FROM covid_deaths
WHERE location = "Mexico"
ORDER BY 1,2;


SELECT location, max(cast(total_deaths as UNSIGNED)) as TotalDeathCount
FROM covid_deaths
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC;


-- GLOBAL NUMBERS

SELECT date, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, 
(SUM(new_deaths)/SUM(new_cases))*100 as DeathPercentage
FROM covid_deaths
WHERE continent is not null
GROUP BY date
ORDER BY 1, 2;

-- Total DeathPct across the world (2.1% of people died)
SELECT SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, 
(SUM(new_deaths)/SUM(new_cases))*100 as DeathPercentage
FROM covid_deaths
WHERE continent is not null
ORDER BY 1, 2;


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as UNSIGNED)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From covid_deaths dea
Join covid_vaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3;

-- Using CTE to perform Calculation on Partition By in previous query
-- Rate of people vaccinated for each country (vax/total_population)

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as UNSIGNED)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From covid_deaths dea
Join covid_vaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
)
Select Location, MAX(Population) as population,
				MAX(RollingPeopleVaccinated) as vaccinated,
                MAX((RollingPeopleVaccinated/Population)*100) as vax_pct
From PopvsVac
GROUP BY Location
ORDER BY vax_pct DESC;


-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as UNSIGNED)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From covid_deaths dea
Join covid_vaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null;

drop view PercentPopulationVaccinated;


