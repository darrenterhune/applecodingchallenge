// app/javascript/controllers/daily_controller.js
import { Controller } from '@hotwired/stimulus';
import * as d3 from 'd3';

export default class extends Controller {
  static targets = ['chart'];

  connect() {
    const dailyData = JSON.parse(this.element.dataset.weather);
    const data = dailyData['time'].map((time, i) => ({
      time: new Date(time),
      tempMax: dailyData['temperature_2m_max'][i],
      tempMin: dailyData['temperature_2m_min'][i],
      precipitation: dailyData['precipitation_sum'][i],
    }));

    const containerWidth = this.element.getBoundingClientRect().width;
    const margin = { top: 20, right: 80, bottom: 30, left: 50 };
    const width = containerWidth - margin.left - margin.right;
    const height = 400 - margin.top - margin.bottom;

    const svg = d3
      .select(this.chartTarget)
      .attr('width', width + margin.left + margin.right)
      .attr('height', height + margin.top + margin.bottom)
      .append('g')
      .attr('transform', `translate(${margin.left},${margin.top})`);

    const x = d3
      .scaleTime()
      .domain(d3.extent(data, d => d.time))
      .range([0, width]);

    const yTemp = d3
      .scaleLinear()
      .domain([
        Math.min(
          d3.min(data, d => d.tempMin),
          d3.min(data, d => d.tempMax),
        ),
        Math.max(
          d3.max(data, d => d.tempMax),
          d3.max(data, d => d.tempMin),
        ),
      ])
      .range([height, 0]);

    const yPrecipitation = d3
      .scaleLinear()
      .domain([0, d3.max(data, d => d.precipitation)])
      .range([height, 0]);

    svg.append('g').attr('transform', `translate(0,${height})`).call(d3.axisBottom(x).ticks(7));

    svg
      .append('g')
      .call(d3.axisLeft(yTemp))
      .append('text')
      .attr('fill', '#000')
      .attr('transform', 'rotate(-90)')
      .attr('y', 6)
      .attr('dy', '0.71em')
      .attr('text-anchor', 'end')
      .text('Temperature (°C)');

    svg
      .append('g')
      .attr('transform', `translate(${width},0)`)
      .call(d3.axisRight(yPrecipitation))
      .append('text')
      .attr('fill', '#000')
      .attr('transform', 'rotate(-90)')
      .attr('y', -6)
      .attr('dy', '0.71em')
      .attr('text-anchor', 'start')
      .text('Precipitation (mm)');

    const lineTempMax = d3
      .line()
      .x(d => x(d.time))
      .y(d => yTemp(d.tempMax));

    const lineTempMin = d3
      .line()
      .x(d => x(d.time))
      .y(d => yTemp(d.tempMin));

    const linePrecipitation = d3
      .line()
      .x(d => x(d.time))
      .y(d => yPrecipitation(d.precipitation));

    svg
      .append('path')
      .datum(data)
      .attr('fill', 'none')
      .attr('stroke', '#f87171')
      .attr('stroke-width', 2)
      .attr('d', lineTempMax);

    svg
      .append('path')
      .datum(data)
      .attr('fill', 'none')
      .attr('stroke', '#60a5fa')
      .attr('stroke-width', 2)
      .attr('d', lineTempMin);

    svg
      .append('path')
      .datum(data)
      .attr('fill', 'none')
      .attr('stroke', '#4ade80')
      .attr('stroke-width', 2)
      .attr('d', linePrecipitation);

    const legend = svg.append('g').attr('transform', `translate(${width - 70}, 10)`);

    legend.append('rect').attr('x', 0).attr('y', 0).attr('width', 10).attr('height', 10).attr('fill', '#f87171');

    legend.append('text').attr('x', 15).attr('y', 10).attr('alignment-baseline', 'middle').text('Temp Max');

    legend.append('rect').attr('x', 0).attr('y', 20).attr('width', 10).attr('height', 10).attr('fill', '#60a5fa');

    legend.append('text').attr('x', 15).attr('y', 30).attr('alignment-baseline', 'middle').text('Temp Min');

    legend.append('rect').attr('x', 0).attr('y', 40).attr('width', 10).attr('height', 10).attr('fill', '#4ade80');

    legend.append('text').attr('x', 15).attr('y', 50).attr('alignment-baseline', 'middle').text('Precipitation');
  }
}
