// app/javascript/controllers/wind_chart_controller.js
import { Controller } from '@hotwired/stimulus';
import * as d3 from 'd3';

export default class extends Controller {
  static targets = ['chart'];

  connect() {
    const hourlyData = JSON.parse(this.element.dataset.weather);
    const data = hourlyData['time'].map((time, i) => ({
      time: new Date(time),
      windSpeed: hourlyData['wind_speed_80m'][i],
    }));

    const containerWidth = this.element.getBoundingClientRect().width;
    const margin = { top: 20, right: 20, bottom: 30, left: 50 };
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

    const y = d3
      .scaleLinear()
      .domain([0, d3.max(data, d => d.windSpeed)])
      .range([height, 0]);

    svg.append('g').attr('transform', `translate(0,${height})`).call(d3.axisBottom(x).ticks(10));

    svg
      .append('g')
      .call(d3.axisLeft(y))
      .append('text')
      .attr('fill', '#000')
      .attr('transform', 'rotate(-90)')
      .attr('y', 6)
      .attr('dy', '0.71em')
      .attr('text-anchor', 'end')
      .text('Wind Speed (km/h)');

    const line = d3
      .line()
      .x(d => x(d.time))
      .y(d => y(d.windSpeed));

    svg
      .append('path')
      .datum(data)
      .attr('fill', 'none')
      .attr('stroke', '#4ade80')
      .attr('stroke-width', 2)
      .attr('d', line);
  }
}
