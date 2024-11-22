SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent is NOT NULL
ORDER BY 3, 4

SELECT [location], [date], total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
ORDER BY 1, 2

-- Looking at total cases vs total deaths
SELECT [location], [date], total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE [location] like '%states%'
ORDER BY 1, 2

-- Looking at total cases vs population
-- Shows what percentage of population got covid
SELECT [location], [date], population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
-- WHERE [location] like '%states%'
WHERE continent is NOT NULL
ORDER BY 1, 2

-- Looking at countries with highest infection rate compared to population
SELECT [location], population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
-- WHERE [location] like '%states%'
WHERE continent is NOT NULL
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

-- Showing countries with the highest death count per population
SELECT [location], MAX(CAST(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
-- WHERE [location] like '%states%'
WHERE continent is NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC

-- LET'S BREAK THINGS DOWN BY CONTINENT
SELECT [continent], MAX(CAST(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
-- WHERE [location] like '%states%'
WHERE continent is NOT NULL
GROUP BY [continent]
ORDER BY TotalDeathCount DESC

-- Showing the continent with the highest death count per population
SELECT [continent], MAX(CAST(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is NOT NULL
GROUP BY [continent]
ORDER BY TotalDeathCount DESC

-- GLOBAL NUMBERS
SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
-- WHERE [location] like '%states%'
WHERE continent is NOT NULL
-- GROUP BY date
ORDER BY 1, 2

-- USE CTE
WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS
(
-- Looking at total population vs vaccinations
SELECT dea.continent, dea.[location], dea.[date], dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
    ON dea.[location] = vac.[location]
    AND dea.[date] = vac.[date]
WHERE dea.continent is NOT NULL
-- ORDER BY 2, 3
)
SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PopvsVac